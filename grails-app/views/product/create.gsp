<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create New Product</title>
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
<h1>Create New Product</h1>
<g:if test="${flash.message}">
    <div class="flash-message">
        <p>${flash.message}</p>
    </div>
</g:if>
<form action="${createLink(action: 'save')}" method="POST">
    <fieldset>
        <label for="barcode">Barcode:</label>
        <input type="text" id="barcode" name="barcode" value="${product?.barcode}" required />
        <br>
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" value="${product?.title}" required />
        <br>
        <label for="price">Price:</label>
        <input type="number" id="price" name="price" value="${product?.price}" required />
        <br>
        <label for="creationDate">Production Date:</label>
        <g:datePicker name="creationDate" value="${new Date()}" precision="day" />
        <br>
        <label for="deadlineCheckbox">
            <input type="checkbox" id="deadlineCheckbox" onclick="toggleDeadline()" checked> Set Deadline
        </label>
        <div id="deadlineField">
            <label for="deadline">Deadline:</label>
            <g:datePicker name="deadline" value="${new Date()}" precision="day" />
        </div>
        <br>
        <button type="submit">Save</button>
    </fieldset>
</form>
<a href="${createLink(action: 'index')}" class="back-link">Back to List</a>

<script>
    function toggleDeadline() {
        var checkbox = document.getElementById('deadlineCheckbox');
        var deadlineField = document.getElementById('deadlineField');
        if (checkbox.checked) {
            deadlineField.style.display = 'block';
        } else {
            deadlineField.style.display = 'none';
            document.getElementsByName('deadline')[0].value = null;
        }
    }
</script>

</body>
</html>
