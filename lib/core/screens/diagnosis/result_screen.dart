import 'package:flutter/material.dart';
import 'package:leafolyze/blocs/detection/detection_event.dart';
import 'package:leafolyze/blocs/product/product_bloc.dart';
import 'package:leafolyze/blocs/product/product_event.dart';
import 'package:leafolyze/blocs/product/product_state.dart';
import 'package:leafolyze/utils/constants.dart';
import 'package:leafolyze/core/screens/diagnosis/deskripsi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/models/product.dart';
import 'package:leafolyze/blocs/detection/detection_bloc.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends StatefulWidget {
  final String title;
  final List<int> diseaseIds;
  final String imageUrl;
  final String description;
  final String treatmentTitle;
  final List<String> treatments;
  final String pesticideTitle;
  final List<String> pesticides;
  final String timestamp;
  final int detectionId;

  const ResultScreen({
    super.key,
    required this.title,
    required this.diseaseIds,
    required this.imageUrl,
    required this.description,
    required this.treatmentTitle,
    required this.treatments,
    required this.pesticideTitle,
    required this.pesticides,
    required this.timestamp,
    required this.detectionId,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    for (var diseaseId in widget.diseaseIds) {
      context.read<ProductBloc>().add(LoadProductsByDisease(diseaseId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text("Result", style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          // Expanded content with white background
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              widget.imageUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const SizedBox(height: 8),
                                Text(
                                  widget.timestamp,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...widget.diseaseIds.map((diseaseId) {
                      final diseaseData =
                          DiseaseDataProvider.diseases[diseaseId];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            diseaseData?.name ?? '',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            diseaseData?.description ?? '',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            widget.treatmentTitle,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...(diseaseData?.treatments ?? [])
                              .map((treatment) => _buildBulletPoint(treatment)),
                        ],
                      );
                    }).toList(),
                    const SizedBox(height: 20),
                    Text(
                      widget.pesticideTitle,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state is ProductLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is ProductLoaded) {
                          return _buildPesticideList(state.products);
                        }

                        return const SizedBox();
                      },
                    ),
                    const SizedBox(height: AppSpacing.spacingM),
                  ],
                ),
              ),
            ),
          ),
          // Bottom Button section with white background
          Container(
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: _buildActionButton(
                    "Re-generate",
                    Colors.white,
                    AppColors.primaryColor,
                    _handleRegenerate,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionButton(
                    "Hapus",
                    Colors.white,
                    Colors.redAccent,
                    () async {
                      // Tampilkan dialog konfirmasi
                      final shouldDelete = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Konfirmasi Hapus'),
                          content: const Text(
                              'Apakah Anda yakin ingin menghapus hasil diagnosis ini?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                'Hapus',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );

                      if (shouldDelete == true) {
                        // Dispatch event untuk menghapus deteksi
                        context
                            .read<DetectionBloc>()
                            .add(Delete(widget.detectionId));

                        // Kembali ke halaman sebelumnya
                        if (context.mounted) {
                          context.pop();
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPesticideList(List<Product> products) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: products.map((product) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.image?.path ?? '',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.broken_image,
                      size: 80,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Rp ${product.price}',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActionButton(String label, Color textColor,
      Color backgroundColor, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _handleRegenerate() async {
    context.read<DetectionBloc>().add(
          UpdateDetection(
            id: widget.detectionId,
            title: widget.title,
            imagePath: widget.imageUrl,
            diseaseIds: widget.diseaseIds,
          ),
        );

    context.push('/diagnose', extra: {
      'imageUrl': widget.imageUrl,
      'isRegenerate': true,
      'detectionId': widget.detectionId,
      'title': widget.title,
      'diseaseIds': widget.diseaseIds,
      'skipLabelInput': true,
    });
  }
}
