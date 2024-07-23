package producttracker


class StorageController {

    StorageService storageService

    static allowedMethods = [index : "GET", show: "GET",
                             save  : "POST", update: "PUT",
                             delete: "DELETE", removeProduct: "DELETE"]


    def index() {
        [storages: storageService.list()]
    }

    def create() {
        [storage: new Storage()]
    }

    def save(Storage storage) {
        try {
            storageService.save(storage)
            flash.message = "Storage saved successfully"
            redirect(action: "index")
        } catch (e) {
            flash.error = e.getMessage()
            redirect(action: "create")
        }
    }

    def delete(String id) {
        UUID storageId = UUID.fromString(id)
        try {
            storageService.delete(storageId)
            flash.message = "Storage deleted successfully"
        } catch (e) {
            flash.erorr = e.getMessage()
        }
        redirect(action: "index")
    }

    def edit(String id) {
        UUID storageId = UUID.fromString(id)
        try {
            def storage = storageService.findById(storageId)
            [storage: storage]
        } catch (e) {
            flash.error = e.getMessage()
            redirect(action: "index")
        }
    }

    def update(Storage storage) {
        try {
            storageService.edit(storage)
            flash.message = "Storage updated successfully."
        } catch (e) {
            flash.error = e.getMessage()
        }
        redirect(action: "index")
    }

    def show(String id) {
        try {
            def storage = storageService.findById(UUID.fromString(id))
            def allProducts = Product.list()
            def storageProducts = storage.storageProducts.collect { it.product }
            [storage: storage, allProducts: allProducts, storageProducts: storageProducts, stores: Store.list()]
        } catch (e) {
            flash.error = e.getMessage()
            redirect(action: "index")
        }
    }

    def saveProduct(String id, String productCode, Integer quantity) {
        UUID storageId = UUID.fromString(id)
        try {
            storageService.addOrUpdateProduct(storageId, productCode, quantity)
        } catch (Exception e) {
            log.error("Error saving product: ${e.message}", e)
            flash.error = e.getMessage()
        }
        redirect(action: "show", id: id)
    }

    def deliverProduct(String id, String productCode, int quantity, String storeId) {
        UUID storageUUID = UUID.fromString(id)
        UUID storeUUID = UUID.fromString(storeId)
        try {
            storageService.deliverProduct(storageUUID, productCode, quantity, storeUUID)
            flash.message = "Product delivered successfully."
        } catch (Exception e) {
            flash.error = e.getMessage()
        }
        redirect(action: "show", id: id)
    }

    def removeProduct(String id, String productCode, int quantity) {
        UUID storageId = UUID.fromString(id)
        try {
            storageService.removeProduct(storageId, productCode, quantity)
            flash.message = "Product removed successfully."
        } catch (e) {
            flash.error = e.getMessage()
        }
        redirect(action: "show", id: id)
    }
}