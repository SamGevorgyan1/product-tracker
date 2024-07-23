<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product ${product?.title}</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
    }
    h1 {
        color: #333;
    }
    form {
        margin-top: 20px;
    }
    label {
        display: block;
        margin-bottom: 5px;
    }
    input[type="text"], input[type="number"], button {
        padding: 8px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 4px;
        width: 200px;
        margin-bottom: 10px;
    }
    button {
        background-color: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
    }
    button:hover {
        background-color: #45a049;
    }
    .back-link {
        margin-top: 10px;
        display: inline-block;
        text-decoration: none;
        color: #007bff;
    }
    .back-link:hover {
        text-decoration: underline;
    }
    .flash-message {
        color: red;
        margin-bottom: 20px;
    }
    </style>
</head>
<body>
<h1>Edit Product ${product?.title}</h1>
<g:if test="${flash.message}">
    <div class="flash-message">
        <p>${flash.message}</p>
    </div>
</g:if>
<form action="${createLink(action: 'update')}" method="POST">
    <fieldset>
        <input type="hidden" name="_method" value="PUT" />
        <input type="hidden" name="id" value="${product?.id}" />
        <label for="barcode">Barcode:</label>
        <input type="text" id="barcode" name="barcode" value="${product?.barcode}" required />
        <br>
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" value="${product?.title}" required />
        <br>
        <label for="price">Price:</label>
        <input type="number" id="price" name="price" value="${product?.price}" required />
        <br>
        <label for="productionDate">Production Date:</label>
        <input type="text" id="productionDate" name="productionDate" value="${product?.creationDate}" readonly />
        <br>
        <label for="deadline">Deadline:</label>
        <input type="text" id="deadline" name="deadline" value="${product?.deadline}" readonly />
        <br>
        <button type="submit">Update</button>
    </fieldset>
</form>
<a href="${createLink(action: 'index')}" class="back-link">Back to List</a>
</body>
</html>
