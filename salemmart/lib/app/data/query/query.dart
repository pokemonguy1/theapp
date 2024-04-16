class QueryApp {
  static const ACTIVE_ORDER_FRAGMENT = /*GraphQL*/ """
  fragment ActiveOrder on Order {
  __typename
  id
  code
  couponCodes
  state
  currencyCode
  totalQuantity
  subTotalWithTax
  shippingWithTax
  totalWithTax
  discounts {
  description
  amountWithTax
}
lines {
id
unitPriceWithTax
quantity
linePriceWithTax
productVariant {
id
name
sku
}
featuredAsset {
id
preview
}
}
shippingLines {
shippingMethod {
description
}
priceWithTax
}
}""";

  static String allhomeCategory = """
  query{
  collections(options: { topLevelOnly: true, }) {
    totalItems
    items {
      id
      slug
      name
      parentId
      featuredAsset {
        id
        preview
      }
    }
  }
}
""";
  static String allCategory = """
  query{
  collections(options: { topLevelOnly: false, }) {
    totalItems
    items {
      id
      slug
      name
      parentId
      featuredAsset {
        id
        preview
      }
    }
  }
}
""";
  static String categoryOfSelectedCollection = """
query GetCollection(\$slug: String!) {
  collection(slug: \$slug) {
    id
    name
    slug
    description
    featuredAsset {
      id
      preview
    }
     children{
      id
      name
      slug
      featuredAsset{
        preview
      }
    }
  }
}
""";

  static String getCollectionProducts = """
query GetCollectionProducts(\$slug: String!, \$skip: Int, \$take: Int) {
  search(
    input: {
      collectionSlug: \$slug,
      groupByProduct: true,
      skip: \$skip,
      take: \$take
      
      }
  ) {
    totalItems
    facetValues {
      count
      facetValue {
        id
        name
        facet {
          id
          name
        }
      }
    }
    items {
      productName
      slug
      productAsset {
        id
        preview
      }
      priceWithTax {
        ... on SinglePrice {
          value
        }
        ... on PriceRange {
          min
          max
        }
      }
      currencyCode
    }
  }
}
""";

  static String ProductDetail = """
  query GetProductDetail(\$slug: String!) {
   product(slug: \$slug) {
    id
    name
    description
    featuredAsset {
      id
      preview
    }
    assets {
      id
      preview
    }
    facetValues{
      id
      name
      code
      facet{
        name
      }
    }
    variants {
      id
      name
      sku
      stockLevel
      currencyCode
      price
      priceWithTax
      featuredAsset {
        id
        preview
      }
      assets {
        id
        preview
      }
    }
  }
}

""";

  static const homeProducts = """
query MyQuery {
  search(input: {groupByProduct: true,take: 14}) {
    totalItems
    items {
      productName
      productVariantName
      productVariantId
      slug
      productAsset {
        preview
      }
      priceWithTax {
        ... on PriceRange {
          __typename
          max
          min
        }
      }
    }
  }
}

""";

  static const search = """
query SearchProducts(\$term: String!, \$skip: Int, \$take: Int) {
  search(
    input: {
      term: \$term,
      groupByProduct: true,
      skip: \$skip,
      take:\$take }
  ) {
    totalItems
    items {
      productName
      slug
      productAsset {
        id
        preview
      }
      priceWithTax {
        ... on SinglePrice {
          value
        }
        ... on PriceRange {
          min
          max
        }
      }
      currencyCode
    }
  }
}

""";
  static const activeOrder = """
    query {
    activeOrder {
  id
  code
  couponCodes
  state
  currencyCode
  totalQuantity
  subTotalWithTax
  shippingWithTax
  totalWithTax
  discounts {
    description
    amountWithTax
  }
  lines {
    id
    unitPriceWithTax
    quantity
    linePriceWithTax
    productVariant {
      id
      name
      sku
    }
    featuredAsset {
      id
      preview
    }
  }
  shippingLines {
    shippingMethod {
      description
    }
    priceWithTax
  }
    
  }
  }
  """;
}
