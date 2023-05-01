import 'package:flutter/material.dart';
import 'package:kitchen_helper/models/recipe.dart';

class RecipeItem extends StatelessWidget {
  const RecipeItem({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(
        context: context,
        builder: (context) => Dialog(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  recipe.name,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
              Text(
                recipe.instructions,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  recipe.imageUrl,
                  height: 100,
                  filterQuality: FilterQuality.medium,
                  width: 100,
                ),
              ),
            ),
            Expanded(
              child: Text(recipe.name),
            ),
          ],
        ),
      ),
    );
  }
}
