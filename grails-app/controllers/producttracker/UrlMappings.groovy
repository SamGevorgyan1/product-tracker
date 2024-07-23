package producttracker

class UrlMappings {

    static mappings = {
        // Root URL mapping
        "/"(controller: 'home', action: 'index')

        // Product mappings
        "/product/create"(controller: 'product', action: 'create')
        "/product/index"(controller: 'product', action: 'index')
        "/product/save"(controller: 'product', action: 'save')
        "/product/update"(controller: 'product', action: 'update')
        "/product/show/$id?"(controller: 'product', action: 'show')
        "/product/edit/$id?"(controller: 'product', action: 'edit')
        "/product/delete/$id?"(controller: 'product', action: 'delete')

        // Store mappings
        "/store/create"(controller: 'store', action: 'create')
        "/store/index"(controller: 'store', action: 'index')
        "/store/save"(controller: 'store', action: 'save')
        "/store/show/$id"(controller: 'store', action: 'show')
        "/store/delete/$id?"(controller: 'store', action: 'delete')
        "/store/sellProduct"(controller: 'store', action: 'sellProduct')
        "/store/returnProductToStorage"(controller: 'store', action: 'returnProductToStorage')

        // Storage mappings
        "/storage/saveProduct"(controller: 'storage', action: 'saveProduct')
        "/storage/deliverProduct"(controller: 'storage', action: 'deliverProduct')
        "/storage/removeProduct"(controller: 'storage', action: 'removeProduct')
        "/storage"(controller: 'storage', action: 'index')
        "/storage/create"(controller: 'storage', action: 'create')
        "/storage/save"(controller: 'storage', action: 'save')
        "/storage/edit/$id"(controller: 'storage', action: 'edit')
        "/storage/update"(controller: 'storage', action: 'update')
        "/storage/delete/$id"(controller: 'storage', action: 'delete')
        "/storage/show/$id"(controller: 'storage', action: 'show')

        "500"(view: '/error')
        "404"(view: '/notFound')
    }
}
