# Public: Contains the logic for doing concept-filtering (tag based) suggestions.
# The core idea is to include some behaviour to the models.
#
# Examples
#
#   user.suggest "products"
#   # => [#<Product _id: 1, ... >, ...]
#
#   user.suggest "users"
#   # => [#<User _id: 1, ... >, ...]
module Bildung

  # Public: Contains a set of formulas aimed to calculate different values needed to make the suggestions.
  #
  # Examples
  #
  #   Bildung::Formulae.cosine_similarity [ 1, 0.5, 0.5 ], [ 1, 0.5, 0.25 ]
  #   # => 0.81
  class Formulae

    # Public: Cosine-based similarity.
    # Entities are items in the m dimensional entity_i space.
    # Depending on the scenarios, the comparisons could be entity_i - entity_i or entity_i - entity_j,
    # while the concept vectors are still weighted against the tags (entity conceptuality).
    # Sparsity must be avoided dealing with nil values.
    #
    # Examples
    #
    #   Bildung::Formulae.cosine_similarity user.conceptual_vector, product.conceptual_vector
    #   # => 0.79
    #
    #   Bildung::Formulae.cosine_similarity product_1.conceptual_vector, product_2.conceptual_vector
    #   # => 0.61
    #
    # Returns a scalar representing the similarity.
    def self.cosine_similarity vector_1, vector_2, round = 5
      vector_1, vector_2 = NVector.to_na(vector_1).to_f, NVector.to_na(vector_2).to_f
      ( ( vector_1 * vector_2 ) / Math.sqrt( vector_1 ** 2 + vector_2 ** 2 ) ).round(round)
    end

    # Public: Correlation-based similarity.
    # The similarity between entities is measured by computing the Pearson-r correlation.
    # The comparisons should be entity_i - entity_i.
    # Sparsity must be avoided dealing with nil values.
    #
    # Examples
    #
    #   Bildung::Formulae.pearson_similarity user.conceptual_vector, product.conceptual_vector
    #   # => 0.7
    #
    #   Bildung::Formulae.pearson_similarity product_1.conceptual_vector, product_2.conceptual_vector
    #   # => 0.55
    #
    # Returns a scalar representing the similarity.
    def self.pearson_similarity vector_1, vector_2, round = 5
      vector_1, vector_2 = vector_1.to_scale, vector_2.to_scale
      Statsample::Bivariate.pearson( vector_1, vector_2 ).round(round)
    end
  end

  # Public: Suggestions (just that!).
  #
  # Examples
  #
  #   user.suggest "products"
  #   # => [#<Product _id: 1, ... >, ...]
  class Suggestions

    # Public: Suggest entities that are conceptually akin to the requester entity.
    # The schema is [entity] like these [concepts] so I suggest him these [entities]
    #
    # Examples
    #
    #   user.suggest_products
    #   # => [#<Product _id: 1, ... >, ...]
    #
    # Returns an array of products.
    def suggest entities limit = 10
      # to-do (ja!)
    end
  end
end