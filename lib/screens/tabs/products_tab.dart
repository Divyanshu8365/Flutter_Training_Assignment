import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_app/providers/product_provider.dart';
import 'package:my_app/screens/product_detail_screen.dart';
import 'package:my_app/models/product_model.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    if (productProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (productProvider.products.isEmpty) {
      return const Center(child: Text("No product found."));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: productProvider.products.length,
      itemBuilder: (context, index) {
        final Product product = productProvider.products[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.thumbnail,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                    size: 40),
              ),
            ),
            title: Text(
              product.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("\$${product.price.toStringAsFixed(2)}",
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.w500)),
                Row(
                  children: [
                    Icon(Icons.star, size: 14, color: Colors.amber.shade700),
                    const SizedBox(width: 4),
                    Text(product.rating.toString(),
                        style: TextStyle(color: Colors.grey.shade700)),
                  ],
                ),
                Text("Stock: ${product.stock}",
                    style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward,
                color: Colors.deepPurple, size: 20),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: product),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
