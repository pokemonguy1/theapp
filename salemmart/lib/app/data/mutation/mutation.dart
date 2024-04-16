class MutationAPp {
  static String login = """
mutation LogIn(\$emailAddress: String!, \$password: String!, \$rememberMe: Boolean!) {
  login(username: \$emailAddress, password: \$password, rememberMe: \$rememberMe) {
    ... on  CurrentUser {
      id
      identifier
    }
    ... on ErrorResult {
      errorCode
      message
    }
  }
}

""";

  static String signup = """
mutation Register(\$input: RegisterCustomerInput!) {
  registerCustomerAccount(input: \$input) {
    ... on Success {
      success
    }
    ...on ErrorResult {
      errorCode
      message
    }
  }
}

""";

  static String addItemToOrder = """
mutation AddItemToOrder(\$variantId: ID!, \$quantity: Int!) {
  addItemToOrder(productVariantId: \$variantId, quantity: \$quantity) {
    __typename
    ...UpdatedOrder
    ... on ErrorResult {
      errorCode
      message
    }
    ... on InsufficientStockError {
      quantityAvailable
      order {
        ...UpdatedOrder
      }
    }
  }
}

fragment UpdatedOrder on Order {
  id
  code
  state
  totalQuantity
  totalWithTax
  currencyCode
  lines {
    id
    unitPriceWithTax
    quantity
    linePriceWithTax
    productVariant {
      id
      name
       featuredAsset {
        preview
      }
    }
  }
}
""";
}
