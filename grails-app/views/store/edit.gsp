<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Edit Store</title>
</head>
<body>
<h1>Edit Store</h1>
<g:form url="[controller: 'store', action: 'update']" method="POST">
    <fieldset>
        <label for="name">Name</label>
        <input type="text" name="name" id="name" value="${storeInstance?.name ?: ''}" required/>

        <label for="address">Address</label>
        <input type="text" name="address" id="address" value="${storeInstance?.address ?: ''}" required/>

        <g:hiddenField name="id" value="${storeInstance?.id}"/>

        <button type="submit">Update</button>
    </fieldset>
</g:form>
</body>
</html>
