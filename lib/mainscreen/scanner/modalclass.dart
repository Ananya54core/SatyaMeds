class Medicine {
  final String label;
  final String commonName;
  final String scientificName;
  final MedicinalValues medicinalValues;
  final UsageAndPreparation usageAndPreparation;
  final List<String> diseaseCures;
  final List<String> possibleSideEffects;
  final List<String> interactionWarnings;
  final List<Recipe> recipes;
  final String path;
  final String manufacturer;
  final String expiryDate;
  final bool prescriptionRequired;

  Medicine({
    required this.label,
    required this.commonName,
    required this.scientificName,
    required this.medicinalValues,
    required this.usageAndPreparation,
    required this.diseaseCures,
    required this.possibleSideEffects,
    required this.interactionWarnings,
    required this.recipes,
    required this.path,
    required this.manufacturer,
    required this.expiryDate,
    required this.prescriptionRequired,
  });

  // Create from JSON factory
  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      label: json['label'],
      commonName: json['commonName'],
      scientificName: json['scientificName'],
      medicinalValues: MedicinalValues.fromJson(json['medicinalValues']),
      usageAndPreparation: UsageAndPreparation.fromJson(json['usageAndPreparation']),
      diseaseCures: List<String>.from(json['diseaseCures']),
      possibleSideEffects: List<String>.from(json['possibleSideEffects']),
      interactionWarnings: List<String>.from(json['interactionWarnings']),
      recipes: (json['recipes'] as List).map((e) => Recipe.fromJson(e)).toList(),
      path: json['path'],
      manufacturer: json['manufacturer'],
      expiryDate: json['expiryDate'],
      prescriptionRequired: json['prescriptionRequired'],
    );
  }

  @override
  String toString() {
    return '''
    Medicine:
    - Label: $label
    - Common Name: $commonName
    - Scientific Name: $scientificName
    - Medicinal Values: $medicinalValues
    - Usage and Preparation: $usageAndPreparation
    - Disease Cures: ${diseaseCures.join(", ")}
    - Possible Side Effects: ${possibleSideEffects.join(", ")}
    - Interaction Warnings: ${interactionWarnings.join(", ")}
    - Recipes: ${recipes.join("\n")}
    - Path: $path
    - Manufacturer: $manufacturer
    - Expiry Date: $expiryDate
    - Prescription Required: $prescriptionRequired
    ''';
  }
}

class MedicinalValues {
  final List<String> healthBenefits;
  final List<String> keyActiveCompounds;
  final List<String> values;

  MedicinalValues({
    required this.healthBenefits,
    required this.keyActiveCompounds,
    required this.values,
  });

  factory MedicinalValues.fromJson(Map<String, dynamic> json) {
    return MedicinalValues(
      healthBenefits: List<String>.from(json['healthBenefits']),
      keyActiveCompounds: List<String>.from(json['keyActiveCompounds']),
      values: List<String>.from(json['values']),
    );
  }

  @override
  String toString() {
    return '''
    Health Benefits: ${healthBenefits.join(", ")}
    Key Active Compounds: ${keyActiveCompounds.join(", ")}
    Values: ${values.join(", ")}
    ''';
  }
}

class UsageAndPreparation {
  final List<String> preparationMethods;
  final String recommendedDosage;
  final String usage;

  UsageAndPreparation({
    required this.preparationMethods,
    required this.recommendedDosage,
    required this.usage,
  });

  factory UsageAndPreparation.fromJson(Map<String, dynamic> json) {
    return UsageAndPreparation(
      preparationMethods: List<String>.from(json['preparationMethods']),
      recommendedDosage: json['recommendedDosage'],
      usage: json['usage'],
    );
  }

  @override
  String toString() {
    return '''
    Preparation Methods: ${preparationMethods.join(", ")}
    Recommended Dosage: $recommendedDosage
    Usage: $usage
    ''';
  }
}

class Recipe {
  final List<String> ingredients;
  final List<String> preparation;
  final List<String> benefits;

  Recipe({
    required this.ingredients,
    required this.preparation,
    required this.benefits,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      ingredients: List<String>.from(json['ingredients']),
      preparation: List<String>.from(json['preparation']),
      benefits: List<String>.from(json['benefits']),
    );
  }

  @override
  String toString() {
    return '''
    Ingredients: ${ingredients.join(", ")}
    Preparation: ${preparation.join(", ")}
    Benefits: ${benefits.join(", ")}
    ''';
  }
}
