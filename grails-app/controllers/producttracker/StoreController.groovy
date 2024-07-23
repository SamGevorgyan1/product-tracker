package producttracker


class StoreController {

    StoreService storeService


    def create() {
        [storeInstance: new Store()]
    }

    def show() {
        UUID id = UUID.fromString((String) params.id)
        try {
            def store = storeService.findById(id)
            [store: store]
        } catch (e) {
            flash.message = e.getMessage()
            redirect(action: "index")
        }
    }

    def index() {
        [stores: storeService.list()]
    }

    def save(Store store) {
        try {
            store.address = params.address
            storeService.create(store)
            redirect(action: "index")
        } catch (e) {
            flash.message = "Error saving store: ${e.message}"
            redirect(action: "create")
        }
    }

    def sellProduct() {
        UUID storeId = UUID.fromString((String) params.storeId)
        String productCode = params.productCode
        int quantity = params.int('quantity')
        try {
            storeService.sellProduct(storeId, productCode, quantity)
            flash.message = "Product sold successfully"
        } catch (e) {
            flash.error = e.message
        }
        redirect(action: 'show', params: [id: storeId])
    }

    def returnProductToStorage() {
        UUID storeId = UUID.fromString((String) params.storeId)
        String productCode = params.productCode
        int quantity = params.int('quantity')
        UUID storageUUID = UUID.fromString((String) params.storageId)
        try {
            storeService.returnProductToStorage(storeId, storageUUID, productCode, quantity)
            flash.message = "Product returned to storage successfully"
        } catch (Exception e) {
            flash.error = e.message
        }
        redirect(action: 'show', id: storeId)
    }

    def edit() {
        UUID id = UUID.fromString((String) params.storeId)
        def storeInstance = storeService.findById(id)
        [storeInstance: storeInstance]
    }

    def update(Store storeInstance) {
        if (storeInstance.save(flush: true)) {
            redirect(action: "index")
        } else {
            render(view: "edit", model: [storeInstance: storeInstance])
        }
    }

    def delete() {
        UUID storeId = UUID.fromString((String) params.id)
        try {
            storeService.delete(storeId)
            flash.message = "Store deleted successfully"
        } catch (e) {
            flash.erorr = e.getMessage()
        }
        redirect(action: "index")
    }
}