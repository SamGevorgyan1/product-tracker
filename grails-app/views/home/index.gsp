<!DOCTYPE html>
<html>
<head>
    <title>Home</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f4;
    }

    .container {
        width: 80%;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        border-radius: 8px;
    }

    h1 {
        color: #333;
        border-bottom: 2px solid #4CAF50;
        padding-bottom: 10px;
        margin-bottom: 20px;
    }

    h2 {
        color: #4CAF50;
        border-bottom: 1px solid #ddd;
        padding-bottom: 8px;
        margin-bottom: 20px;
    }

    a {
        color: #4CAF50;
        text-decoration: none;
        font-weight: bold;
    }

    a:hover {
        text-decoration: underline;
    }

    ul {
        list-style-type: none;
        padding: 0;
    }

    li {
        background-color: #fff;
        margin: 10px 0;
        padding: 15px;
        border-radius: 5px;
        box-shadow: 0 0 5px rgba(0,0,0,0.1);
    }

    .actions {
        margin-top: 10px;
    }

    .actions a {
        margin-right: 10px;
        color: #333;
        text-decoration: none;
    }

    .actions a:hover {
        text-decoration: underline;
    }

    .actions .delete {
        color: #f44336;
    }

    .actions .delete:hover {
        text-decoration: none;
    }

    form {
        display: inline;
    }
    </style>
</head>
<body>
<div class="container">
    <h1>Home</h1>

    <h2>Storages</h2>
    <a href="${createLink(controller: 'storage', action: 'create')}">Add New Storage</a>
    <ul>
        <g:each in="${storages}" var="storage">
            <li>
                ${storage.name}
                <span class="actions">
                    <a href="${createLink(controller: 'storage', action: 'show', id: storage.id)}">View Details</a> |
                    <form action="${createLink(controller: 'storage', action: 'delete', id: storage.id)}" method="post" style="display:inline;">
                        <input type="hidden" name="_method" value="DELETE" />
                        <button type="submit" class="delete" onclick="return confirm('Are you sure you want to delete this storage?');">Delete</button>
                    </form>
                </span>
            </li>
        </g:each>
    </ul>

    <h2>Stores</h2>
    <a href="${createLink(controller: 'store', action: 'create')}">Add New Store</a>
    <ul>
        <g:each in="${stores}" var="store">
            <li>
                ${store.name} - ${store.address}
                <span class="actions">
                    <a href="${createLink(controller: 'store', action: 'show', id: store.id)}">View Details</a> |
                    <form action="${createLink(controller: 'store', action: 'delete', id: store.id)}" method="post" style="display:inline;">
                        <input type="hidden" name="_method" value="DELETE" />
                        <button type="submit" class="delete" onclick="return confirm('Are you sure you want to delete this store?');">Delete</button>
                    </form>
                </span>
            </li>
        </g:each>
    </ul>

    <h2>Products</h2>
    <a href="${createLink(controller: 'product', action: 'create')}">Add New Product</a> |
    <a href="${createLink(controller: 'product', action: 'index')}">See Products</a>
</div>
</body>
</html>
