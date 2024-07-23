<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Store Details</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }

    .container {
        width: 80%;
        margin: 20px auto;
        padding: 20px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
    }

    h1 {
        color: #333;
        border-bottom: 2px solid #4CAF50;
        padding-bottom: 10px;
        margin-bottom: 20px;
    }

    .store-info h2 {
        color: #4CAF50;
        margin-bottom: 10px;
    }

    .store-info p {
        font-size: 1.1em;
        margin-bottom: 20px;
    }

    .products-table table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    .products-table th, .products-table td {
        padding: 10px;
        border: 1px solid #ddd;
        text-align: left;
    }

    .products-table th {
        background-color: #f8f8f8;
    }

    .form-container {
        margin-top: 20px;
        background-color: #f9f9f9;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    }

    .form-container label {
        display: block;
        margin: 10px 0 5px;
    }

    .form-container input[type="text"],
    .form-container input[type="number"] {
        width: calc(100% - 16px);
        padding: 8px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    .form-container input[type="submit"] {
        padding: 10px 15px;
        background-color: #007bff;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    .form-container input[type="submit"]:hover {
        background-color: #0056b3;
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

    .back-link {
        display: inline-block;
        margin-top: 20px;
        padding: 10px 15px;
        background-color: #6c757d;
        color: #fff;
        text-decoration: none;
        border-radius: 4px;
    }

    .back-link:hover {
        background-color: #5a6268;
    }
    </style>
    <script>
        function toggleReturnForm(productId) {
            var form = document.getElementById('returnForm-' + productId);
            if (form.style.display === 'none') {
                form.style.display = 'block';
            } else {
                form.style.display = 'none';
            }
        }
    </script>
</head>
<body>
<div class="container">
    <h1>Store Details</h1>

    <div class="store-info">
        <h2>${store.name}</h2>
        <p><strong>Address:</strong> ${store.address}</p>
    </div>

    <h3>Products in Store</h3>
    <div class="products-table">
        <table>
            <thead>
            <tr>
                <th>Product Code</th>
                <th>Product Name</th>
                <th>Price</th>
                <th>Creation Date</th>
                <th>Deadline</th>
                <th>Quantity</th>
                <th>Storage Name</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${store.storeProducts}" var="storeProduct">
                <tr>
                    <td>${storeProduct.product.barcode}</td>
                    <td>${storeProduct.product.title}</td>
                    <td>${storeProduct.product.price}</td>
                    <td>${storeProduct.product.creationDate}</td>
                    <td>${storeProduct.product.deadline}</td>
                    <td>${storeProduct.quantity}</td>
                    <td>${storeProduct.storage.name}</td>
                    <td>
                        <button onclick="toggleReturnForm('${storeProduct.product.barcode}')">Return to Storage</button>
                        <div id="returnForm-${storeProduct.product.barcode}" style="display:none;">
                            <g:form url="[controller: 'store', action: 'returnProductToStorage']" class="form-container">
                                <input type="hidden" name="storeId" value="${store.id}"/>
                                <input type="hidden" name="storageId" value="${storeProduct.storage.id}"/>
                                <input type="hidden" name="productCode" value="${storeProduct.product.barcode}"/>

                                <label for="quantity">Quantity:</label>
                                <input type="number" id="quantity" name="quantity" min="1" required/>

                                <input type="submit" value="Return Product"/>
                            </g:form>
                        </div>
                    </td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </div>

    <div class="forms">
        <h3>Sell Product</h3>
        <g:form url="[controller: 'store', action: 'sellProduct']" class="form-container">
            <input type="hidden" name="storeId" value="${store.id}"/>

            <label for="productCodeSell">Product Code:</label>
            <input type="text" id="productCodeSell" name="productCode" required/>

            <label for="quantitySell">Quantity:</label>
            <input type="number" id="quantitySell" name="quantity" min="1" required/>

            <input type="submit" value="Sell Product"/>
        </g:form>
    </div>

    <div>
        <a href="${createLink(controller: 'store', action: 'index')}" class="back-link">Back to List</a>
    </div>

    <g:if test="${flash.message}">
        <div class="message success">${flash.message}</div>
    </g:if>
    <g:if test="${flash.error}">
        <div class="message error">${flash.error}</div>
    </g:if>
</div>
</body>
</html>
