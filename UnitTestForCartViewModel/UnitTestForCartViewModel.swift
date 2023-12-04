//
//  UnitTestForCartViewModel.swift
//  UnitTestForCartViewModel
//
//  Created by Sesili Tsikaridze on 04.12.23.
//

import XCTest
@testable import UnitTestingAssignment

final class UnitTestForCartViewModel: XCTestCase {
    
    var cart: CartViewModel!
    
    override func setUpWithError() throws {
        cart = CartViewModel()
    }
    
    override func tearDownWithError() throws {
        cart = nil
    }
    
    func testSelectedItemsQuantity() {
        let firstProduct = Product(title: "first product", selectedQuantity: 4)
        let secondProduct = Product(title: "Second product", selectedQuantity: 7)
        let dummyData = [firstProduct, secondProduct]
        cart.selectedProducts = dummyData
        XCTAssertEqual(cart.selectedItemsQuantity, 11)
    }
    
    func testTotalPrice() {
        let firstProduct = Product(title: "first product", price: 20, selectedQuantity: 2)
        let secondProduct = Product(title: "Second product", price: 10, selectedQuantity: 3)
        let dummyData = [firstProduct, secondProduct]
        cart.selectedProducts = dummyData
        XCTAssertEqual(cart.totalPrice, 70)
    }
    
    func testFetchingProducts() {
        let fetchProductsExpectation = expectation(description: "Fetched Products")
        cart.fetchProducts()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(self.cart.allproducts)
            fetchProductsExpectation.fulfill()
        }
        
        wait(for: [fetchProductsExpectation], timeout: 5)
    }
    
    func testAddProductWithID() {
        let product = Product(id: 1, title: "first product", price: 20, selectedQuantity: 2)
        let dummyData = [product]
        cart.allproducts = dummyData
        cart.selectedProducts = dummyData
        cart.addProduct(withID: 1)
        XCTAssertGreaterThan(cart.allproducts![0].selectedQuantity!, 2)
    }
    
    func testAddProduct() {
        let product = Product(id: 1, title: "first product", price: 20, selectedQuantity: 2)
        let dummyData = [product]
        cart.selectedProducts = dummyData
        cart.addProduct(product: product)
        XCTAssertGreaterThan(cart.selectedProducts[0].selectedQuantity!, 2)
    }
    
    func testRemoveProduct() {
        let firstProduct = Product(id: 1, title: "first product", price: 20, selectedQuantity: 2)
        let secondProduct = Product(id: 2, title: "Second product", price: 10, selectedQuantity: 3)
        let dummyData = [firstProduct, secondProduct]
        cart.selectedProducts = dummyData
        cart.removeProduct(withID: 1)
        XCTAssertLessThan(cart.selectedProducts.count, 2)

    }
    
    func testClearCart() {
        let firstProduct = Product(id: 1, title: "first product", price: 20, selectedQuantity: 2)
        let secondProduct = Product(id: 2, title: "Second product", price: 10, selectedQuantity: 3)
        let dummyData = [firstProduct, secondProduct]
        cart.selectedProducts = dummyData
        cart.clearCart()
        XCTAssertTrue(cart.selectedProducts.count == 0)
    }
    
    
    
}
