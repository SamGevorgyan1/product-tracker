package producttracker


class ProductController {

    ProductService productService

    static allowedMethods = [index: "GET", show: "GET", save: "POST", update: "PUT", delete: "DELETE"]


    def index() {
        def products = productService.list()
        [products: products]
    }

    def show(String id) {
        try {
            def product = productService.get(UUID.fromString(id))
            [product: product]
        } catch (e) {
            flash.error = e.getMessage()
        }
    }

    def create() {
        [product: new Product()]
    }

    def update(Product product) {
        try {
            productService.update(product)
            redirect(action: "show", id: product.id)
        } catch (e) {
            flash.message = e.getMessage()
            redirect(action: "edit", id: product.id)
        }
    }

    def save(Product product) {
        try {
            productService.save(product)
            redirect(action: "show", id: product.id)
        } catch (e) {
            flash.message = e.getMessage()
            redirect(action: "create")
        }
    }

    def edit(String id) {
        UUID productUUID = UUID.fromString(id)
        try {
            def product = productService.get(productUUID)
            [product: product]
        } catch (e) {
            flash.error = e.getMessage()
            redirect(action: "edit", id: productUUID)
        }
    }

    def delete(String id) {
        try {
            productService.delete(UUID.fromString(id))
        } catch (e) {
            flash.error = e.getMessage()
        }
        redirect(action: "index")
    }
}
