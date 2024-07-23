<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List of Products</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
    }
    h1 {
        color: #333;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
    }
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    tr:hover {
        background-color: #f5f5f5;
    }
    .actions {
        white-space: nowrap;
    }
    .actions a, .actions form {
        margin-right: 5px;
    }
    .back-link {
        display: inline-block;
        margin-top: 10px;
        text-decoration: none;
        color: #007bff;
    }
    .back-link:hover {
        text-decoration: underline;
    }
    .flash-message {
        padding: 10px;
        margin-bottom: 20px;
        border-radius: 4px;
    }
    .flash-message.success {
        background-color: #d4edda;
        color: #155724;
        border: 1px solid #c3e6cb;
    }
    .flash-message.error {
        background-color: #f8d7da;
        color: #721c24;
        border: 1px solid #f5c6cb;
    }
    </style>
</head>
<body>
<h1>List of Products</h1>

<g:if test="${flash.message}">
    <div class="flash-message success">${flash.message}</div>
</g:if>
<g:if test="${flash.error}">
    <div class="flash-message error">${flash.error}</div>
</g:if>

<table>
    <thead>
    <tr>
        <th>Barcode</th>
        <th>Title</th>
        <th>Price</th>
        <th>Production Date</th>
        <th>Deadline</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${products}" var="product">
        <tr>
            <td>${product.barcode}</td>
            <td>${product.title}</td>
            <td>${product.price}</td>
            <td>${product.creationDate ?: '-'}</td>
            <td>${product.deadline ?: '-'}</td>
            <td class="actions">
                <g:link action="show" id="${product.id}">Show</g:link> |
                <g:link action="edit" id="${product.id}">Edit</g:link> |
                <g:form action="delete" id="${product.id}" onsubmit="return confirm('Are you sure you want to delete this product?');">
                    <g:hiddenField name="_method" value="DELETE"/>
                    <button type="submit">Delete</button>
                </g:form>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
<a href="${createLink(action: 'create')}" class="back-link">Create New Product</a>
</body>
</html>
