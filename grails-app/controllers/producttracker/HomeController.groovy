package producttracker

class HomeController {

    StorageService storageService
    StoreService storeService

    def index() {
        [storages: storageService.list(), stores: storeService.list()]
    }
}
