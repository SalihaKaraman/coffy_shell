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
  LatLng _initialLocation = const LatLng(41.0503, 28.9918); // Nisantasi default
  Set<Marker> _markers = {};
  Branch? _selectedBranch;
  String _selectedFilter = 'Tümü';
  final List<String> _filters = ['Tümü', 'Yakınımda', 'Açık'];

  @override
  void initState() {
    super.initState();
    branchesViewModel = BranchesViewModel();
    _loadData();
  }

  @override
  void dispose() {
    branchesViewModel.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    await branchesViewModel.fetchBranches();
    if (!mounted) return;
    _createMarkers();
    await _getUserLocation();
    if (!mounted) return;
  }

  void _createMarkers() {
    if (!mounted) return;
    setState(() {
      _markers = branchesViewModel.branches.map((branch) {
        return Marker(
          markerId: MarkerId(branch.id),
          position: LatLng(branch.latitude, branch.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          onTap: () {
            setState(() => _selectedBranch = branch);
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
      body: Stack(
        children: [
          // Full Screen Map
          Positioned.fill(
            child: GoogleMap(
              onMapCreated: (controller) => mapController = controller,
              initialCameraPosition: CameraPosition(
                target: _initialLocation,
                zoom: 12,
              ),
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              padding: const EdgeInsets.only(bottom: 280),
            ),
          ),

          // Top Search and Filters
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Search Bar
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Şube ara...',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, color: AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Filters
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      itemBuilder: (context, index) {
                        final filter = _filters[index];
                        final isSelected = _selectedFilter == filter;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedFilter = filter),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: isSelected ? AppColors.primary : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors.primary),
                              ),
                              child: Center(
                                child: Text(
                                  filter,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Branch List
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListenableBuilder(
                listenable: branchesViewModel,
                builder: (context, child) {
                  if (branchesViewModel.loading) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.terracotta));
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: branchesViewModel.branches.length,
                    itemBuilder: (context, index) {
                      final branch = branchesViewModel.branches[index];
                      return _BranchCard(
                        branch: branch,
                        onTap: () {
                          mapController?.animateCamera(
                            CameraUpdate.newLatLngZoom(
                              LatLng(branch.latitude, branch.longitude),
                              15,
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BranchCard extends StatelessWidget {
  final Branch branch;
  final VoidCallback onTap;

  const _BranchCard({required this.branch, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Image.network(
                'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800', // Default cafe image
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          branch.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.sageGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Şu an Açık',
                          style: TextStyle(color: AppColors.sageGreen, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    branch.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: AppColors.terracotta),
                      const SizedBox(width: 4),
                      const Text('1.2 km', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        child: const Text('Yol Tarifi', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
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
  }
}
