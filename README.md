# better_forms 

This is a simple library to help building forms in Flutter.

# Example
This is an example of how to use this package to create a pretty simple form.

_Note: for a complete working example, you can refer to the main.dart file in the repository_

````dart
class MyForm extends StatelessWidget {
  void _onSubmit(Map<String, String> map) {
    print(map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: BFForm(
            title: Text(
              "Personal info",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            onSubmit: _onSubmit,
            fields: [
              BFFormField(
                name: "name",
                title: "Name",
              ),
              BFFormGroup(
                fields: [
                  BFFormField(
                    name: "surname",
                    title: "First surname",
                  ),
                  BFFormField(
                    name: "second_surname",
                    title: "Second surname",
                  ),
                  BFDropdown(
                    flex: 1,
                    items: [
                      BFDropdownItem<String>(value: "+34", displayValue: "+34"),
                      BFDropdownItem<String>(value: "+90", displayValue: "+90")
                    ],
                    name: "prefix",
                    hint: "Prefix",
                  ),
                  BFFormField(
                    flex: 2,
                    name: "phone",
                    title: "Phone",
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
````

## Result
![the result of the code above](img/sample_use.png)