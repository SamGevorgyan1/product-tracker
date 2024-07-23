package producttracker

import grails.gorm.transactions.Transactional
import java.time.LocalDate


class HandleExpiredProductsJob {

    static triggers = {
        cron name: 'handleExpiredProductsTrigger', cronExpression: '0 0 0 * * ?'
    }

    StoreService storeService

    @Transactional
    def execute() {
        Store.findAll().each { store ->
            store.storeProducts.each { storeProduct ->
                if (storeProduct.product.deadline != null && storeProduct.product.deadline.isBefore(LocalDate.now())) {
                    storeService.returnProductToStorage(store.id, storeProduct.storage.id, storeProduct.product.barcode, storeProduct.quantity)
                }
            }
        }
    }
}