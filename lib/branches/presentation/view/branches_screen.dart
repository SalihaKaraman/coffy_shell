import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coffy_shell/theme/app_colors.dart';
import 'package:coffy_shell/branches/presentation/mvvm/branches_view_model.dart';
import 'package:coffy_shell/branches/domain/entity/branch.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({super.key});

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  late final BranchesViewModel branchesViewModel;
  GoogleMapController? mapController;
  LatLng _initialLocation = const LatLng(41.0082, 28.9784); // Istanbul
  Set<Marker> _markers = {};
  Branch? _selectedBranch;

  @override
  void initState() {
    super.initState();
    branchesViewModel = BranchesViewModel();
    _loadData();
  }

  @override
  void dispose() {
    mapController?.dispose();
    branchesViewModel.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    await branchesViewModel.fetchBranches();
    _createMarkers();
    _getUserLocation();
  }

  void _createMarkers() {
    if (!mounted) return;
    setState(() {
      _markers = branchesViewModel.branches.map((branch) {
        return Marker(
          markerId: MarkerId(branch.id),
          position: LatLng(branch.latitude, branch.longitude),
          infoWindow: InfoWindow(
            title: branch.name,
            snippet: branch.address,
          ),
          onTap: () {
            setState(() {
              _selectedBranch = branch;
            });
          },
        );
      }).toSet();
    });
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      if (permission == LocationPermission.deniedForever) return;

      final position = await Geolocator.getCurrentPosition();
      final userLatLng = LatLng(position.latitude, position.longitude);
      
      if (!mounted) return;
      setState(() {
        _initialLocation = userLatLng;
      });
      
      mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(userLatLng, 13),
      );
    } catch (e) {
      print('Geolocator error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        title: Text(
          'Şubelerimiz',
          style: GoogleFonts.playfairDisplay(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location, color: AppColors.primary),
            onPressed: _getUserLocation,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListenableBuilder(
        listenable: branchesViewModel,
        builder: (context, child) {
          if (branchesViewModel.loading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.terracotta));
          }

          if (branchesViewModel.branches.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.storefront_outlined, size: 64, color: AppColors.surfaceVariant),
                  const SizedBox(height: 16),
                  const Text('Şube bilgisi bulunamadı.'),
                  TextButton(
                    onPressed: _loadData,
                    child: const Text('Tekrar Dene'),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Google Map Section
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: GoogleMap(
                      onMapCreated: (controller) => mapController = controller,
                      initialCameraPosition: CameraPosition(
                        target: _initialLocation,
                        zoom: 11,
                      ),
                      markers: _markers,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      zoomControlsEnabled: false,
                      mapToolbarEnabled: false,
                      style: null, // You can add custom map style here
                    ),
                  ),
                ),
              ),
              
              // Branch List Section
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                    itemCount: branchesViewModel.branches.length,
                    itemBuilder: (context, index) {
                      final branch = branchesViewModel.branches[index];
                      final isSelected = _selectedBranch?.id == branch.id;
                      
                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedBranch = branch);
                          mapController?.animateCamera(
                            CameraUpdate.newLatLngZoom(
                              LatLng(branch.latitude, branch.longitude),
                              15,
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.cream : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? AppColors.terracotta : AppColors.surfaceVariant.withOpacity(0.5),
                              width: isSelected ? 2 : 1,
                            ),
                            boxShadow: isSelected ? [
                              BoxShadow(
                                color: AppColors.terracotta.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ] : [],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceVariant.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Icon(Icons.coffee, color: AppColors.earthyBrown),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      branch.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      branch.address,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: AppColors.onSurfaceVariant.withOpacity(0.7),
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time_rounded, size: 14, color: AppColors.sageGreen),
                                        const SizedBox(width: 4),
                                        Text(
                                          branch.openingHours,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.sageGreen,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const Spacer(),
                                        const Icon(Icons.star_rounded, size: 16, color: Colors.amber),
                                        const SizedBox(width: 2),
                                        Text(
                                          branch.rating.toString(),
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
