<!DOCTYPE html>
<html>
<head>
    <title>Edit Storage</title>
</head>
<body>
<h1>Edit Storage</h1>
<g:form controller="storage" action="update">
    <g:hiddenField name="id" value="${storage.id}" />
    <g:hiddenField name="_method" value="PUT" />
    <fieldset>
        <legend>Storage Details</legend>
        <br/>
        <label for="name">Name:</label>
        <g:textField name="name" id="name" value="${storage.name}" />
        <br/>
        <input type="submit" value="Update" />
    </fieldset>
</g:form>
<a href="${createLink(controller: 'storage', action: 'index')}">Back to List</a>
</body>
</html>
