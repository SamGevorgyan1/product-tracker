<!DOCTYPE html>
<html>
<head>
    <title>Storage Details</title>
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

    .message {
        margin-top: 20px;
        padding: 10px;
        border-radius: 4px;
    }

    .message.success {
        background-color: #d4edda;
        color: #155724;
    }

    .message.error {
        background-color: #f8d7da;
        color: #721c24;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    th, td {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #f2f2f2;
    }

    form {
        margin-bottom: 20px;
        padding: 15px;
        background-color: #f9f9f9;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    form label {
        display: block;
        margin-bottom: 5px;
        color: #333;
    }

    form input[type="text"], form select {
        width: calc(100% - 22px);
        padding: 8px;
        margin-bottom: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
    }

    form input[type="submit"] {
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 10px 15px;
        border-radius: 4px;
        cursor: pointer;
    }

    form input[type="submit"]:hover {
        background-color: #45a049;
    }

    .back-link {
        display: inline-block;
        margin-top: 20px;
        text-decoration: none;
        color: #4CAF50;
        font-weight: bold;
    }

    .back-link:hover {
        text-decoration: underline;
    }
    </style>
</head>
<body>
<div class="container">
    <h1>Storage: ${storage.name}</h1>

    <g:if test="${flash.message}">
        <div class="message success">${flash.message}</div>
    </g:if>
    <g:if test="${flash.error}">
        <div class="message error">${flash.error}</div>
    </g:if>

    <h2>Products</h2>
    <table>
        <thead>
        <tr>
            <th>Product</th>
            <th>Quantity</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${storage.storageProducts}" var="entry">
            <tr>
                <td>${entry.product.title}</td>
                <td>${entry.quantity}</td>
                <td>
                    <g:form url="[controller: 'storage', action: 'removeProduct']" method="post">
                        <input type="hidden" name="id" value="${storage.id}" />
                        <input type="hidden" name="productCode" value="${entry.product.barcode}" />
                        <input type="hidden" name="_method" value="DELETE" />
                        <label for="removeQuantityField-${entry.product.barcode}">Quantity to remove:</label>
                        <g:textField id="removeQuantityField-${entry.product.barcode}" name="quantity" />
                        <input type="submit" value="Remove" />
                    </g:form>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>

    <h2>Add Product</h2>
    <g:form controller="storage" action="saveProduct">
        <input type="hidden" name="id" value="${storage.id}" />
        <label for="productSelect">Product:</label>
        <g:select id="productSelect" name="productCode" from="${allProducts}" optionKey="barcode" optionValue="title" />
        <br/>
        <label for="quantityField">Quantity:</label>
        <g:textField id="quantityField" name="quantity" />
        <br/>
        <input type="submit" value="Add Product" />
    </g:form>

    <h2>Deliver Product</h2>
    <g:form controller="storage" action="deliverProduct">
        <input type="hidden" name="id" value="${storage.id}" />
        <label for="deliveryProductSelect">Product:</label>
        <g:select id="deliveryProductSelect" name="productCode" from="${storageProducts}" optionKey="barcode" optionValue="title" />
        <br/>
        <label for="deliveryQuantityField">Quantity:</label>
        <g:textField id="deliveryQuantityField" name="quantity" />
        <br/>
        <label for="storeSelect">Store:</label>
        <g:select id="storeSelect" name="storeId" from="${stores}" optionKey="id" optionValue="name" />
        <br/>
        <input type="submit" value="Deliver Product" />
    </g:form>

    <a href="${createLink(controller: 'storage', action: 'index')}" class="back-link">Back to List</a>
</div>
</body>
</html>
