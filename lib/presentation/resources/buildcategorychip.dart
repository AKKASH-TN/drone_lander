import 'package:flutter/material.dart';

class BuildCategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const BuildCategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Chip(
          label: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontSize: 14,
            ),
          ),
          backgroundColor: isSelected ? Colors.white : Colors.grey[800],
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }
}

class CategoryList extends StatefulWidget {
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Function(String) onCategorySelected;

  const CategoryList({
    super.key,
    this.height = 40,
    this.padding,
    required this.onCategorySelected,
  });

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: widget.padding,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          BuildCategoryChip(
            label: 'All',
            isSelected: selectedCategory == 'All',
            onTap: () {
              setState(() {
                selectedCategory = 'All';
                widget.onCategorySelected(selectedCategory);
              });
            },
          ),
          BuildCategoryChip(
            label: 'Weather',
            isSelected: selectedCategory == 'Weather',
            onTap: () {
              setState(() {
                selectedCategory = 'Weather';
                widget.onCategorySelected(selectedCategory);
              });
            },
          ),
          BuildCategoryChip(
            label: 'Drone Activity',
            isSelected: selectedCategory == 'Drone Activity',
            onTap: () {
              setState(() {
                selectedCategory = 'Drone Activity';
                widget.onCategorySelected(selectedCategory);
              });
            },
          ),
          BuildCategoryChip(
            label: 'Battery',
            isSelected: selectedCategory == 'Battery',
            onTap: () {
              setState(() {
                selectedCategory = 'Battery';
                widget.onCategorySelected(selectedCategory);
              });
            },
          ),
        ],
      ),
    );
  }
}