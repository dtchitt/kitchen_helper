import 'package:flutter/material.dart';
import 'package:kitchen_helper/data/recipe_fetcher.dart';
import 'package:kitchen_helper/widgets/recipe_item.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({Key? key}) : super(key: key);

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: getRandomRecipes(10),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final recipes = snapshot.data ?? [];
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) => RecipeItem(recipe: recipes[index]),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
