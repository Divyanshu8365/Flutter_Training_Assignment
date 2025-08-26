import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late String selectedImage;
  @override
  void initState() {
    super.initState();
    selectedImage = widget.product.images.isNotEmpty
        ? widget.product.images.first
        : widget.product.thumbnail;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final discountedPrice =
        product.price - (product.price * product.discountPercentage / 100);
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- Main Product Image ---
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(selectedImage,
                    height: 250, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 12),

            /// --- Thumbnails ---
            if (product.images.isNotEmpty)
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.images.length,
                  itemBuilder: (context, index) {
                    final img = product.images[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImage = img;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedImage == img
                                ? Colors.deepPurple
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            img,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),

            /// --- Title & Price ---
            Text(product.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Text(
                  "\$${product.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                      fontSize: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  "\$${discountedPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),

            /// --- Category & Rating ---
            Row(
              children: [
                Chip(
                  label: Text(product.category),
                  backgroundColor: Colors.deepPurple.shade50,
                ),
                const SizedBox(width: 12),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber.shade700, size: 18),
                    const SizedBox(width: 4),
                    Text(product.rating.toString(),
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
            const Divider(height: 32),

            /// --- Tags ---
            if (product.tags.isNotEmpty) ...[
              Text("Tags", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: product.tags
                    .map((tag) => Chip(
                          avatar: const Icon(Icons.tag,
                              size: 16, color: Colors.deepPurple),
                          label: Text(tag),
                          backgroundColor: Colors.deepPurple.shade50,
                        ))
                    .toList(),
              ),
              const Divider(height: 32),
            ],

            /// --- Description ---
            Text("Description", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(product.description),
            const Divider(height: 32),

            /// --- Product Details ---
            Text("Details", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text("SKU: ${product.sku}"),
            Text("Weight: ${product.weight} g"),
            Text(
                "Dimensions: ${product.dimensions.width} x ${product.dimensions.height} x ${product.dimensions.depth} cm"),
            Text("Stock: ${product.stock}"),
            Text("Availability: ${product.availabilityStatus}"),
            Text("Min Order: ${product.minimumOrderQuantity}"),
            const Divider(height: 32),

            /// --- Shipping & Warranty ---
            Text("Shipping Information",
                style: Theme.of(context).textTheme.titleMedium),
            Text(product.shippingInformation),
            const SizedBox(height: 12),
            Text("Warranty", style: Theme.of(context).textTheme.titleMedium),
            Text(product.warrantyInformation),
            const SizedBox(height: 12),
            Text("Return Policy",
                style: Theme.of(context).textTheme.titleMedium),
            Text(product.returnPolicy),
            const Divider(height: 32),

            /// --- Reviews ---
            if (product.reviews.isNotEmpty) ...[
              Text("Customer Reviews",
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              SizedBox(
                height: 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.reviews.length,
                  itemBuilder: (context, index) {
                    final review = product.reviews[index];
                    return SizedBox(
                      width: 250,
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.person,
                                      color: Colors.deepPurple),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      review.reviewerName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                review.comment,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.amber.shade700, size: 16),
                                  const SizedBox(width: 4),
                                  Text("${review.rating}/5"),
                                  const Spacer(),
                                  Text(review.date,
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
