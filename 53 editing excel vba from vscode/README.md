# Purpose

Editing excel's vba from vscode

## Steps

### Install [xlwings](https://docs.xlwings.org/en/stable/installation.html)
```
pip install xlwings

pip install watchgod
```
### To enable macros we'll have to do these
```
Right click on the target Excel > Properties > General > Security > Check the Unblock > Apply > Ok
```

### We'll need to enable settings so that we can access the excel file programmatically  
```
Excel option > Trust Center > Macro Settings > Trust access to the VBA project object model
```

### Open visual studio and run this command
```
xlwings vba edit --file .\SCert_macro_enabled_25_5.xlsm
```

### To help with developing in VBA install this VBA extension in vscode
```
serkonda7.vscode-vba
```