  
  import 'package:demo_project_mohit/custom_widget/custom_text.dart';
  import 'package:flutter/material.dart';
  import '../../Helper/date_converter.dart';
  import '../model/expense_model.dart';
  class NewExpense extends StatefulWidget {
    final void Function(ExpenseModel value) expense;
    const NewExpense({super.key,required this.expense});
  
    @override
    State<NewExpense> createState() => _NewExpenseState();
  }
  
  class _NewExpenseState extends State<NewExpense> {
    final _titleController = TextEditingController();
    final _amountController = TextEditingController();
    DateTime? selectedDate;
    Category _selectedCategory = Category.leisure;
  
    @override
    void dispose() {
      _titleController.dispose();
      _amountController.dispose();
      super.dispose();
    }
  
    @override
    Widget build(BuildContext context) {
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              16,
              16,
              16,
              MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              children: [
                TextField(
                  maxLength: 50,
                  controller: _titleController,
                  onChanged: (String value){
                    print(value);
                  },
                  decoration: const InputDecoration(
                    label: CustomText(
                        "Title",
                        fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        onChanged: (String value){
                          debugPrint(value);
                        },
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: CustomText(
                              "Enter Amount",
                              fontSize: 15,
                              color: Colors.black
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                                selectedDate==null ?
                                "No Date Selected" :
                                DateFormatter.ddMMyyyyDT(selectedDate)
                            ),
                          ),
                         Expanded(
                           child: IconButton(
                               onPressed: _presentDatePicker,
                               icon: Icon(Icons.calendar_month,color: Theme.of(context).appBarTheme.foregroundColor,)
                           ),
                         )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values.map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name.toUpperCase()),
                      )).toList(),
                      onChanged: (value){
                        if(value==null) return;
                        debugPrint(value.name);
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const CustomText(
                            "Cancel",
                            fontSize: 12,
                            color: Colors.black
                        )
                    ),
                    ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const CustomText(
                            "Save expenses",
                            fontSize: 12,
                            color: Colors.black
                        )
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  
    void _presentDatePicker() async{
      final date = DateTime.now();
      final firstdate = DateTime(date.year-1 , date.month , date.day , date.hour, date.minute);
      final value = await showDatePicker(
        context: context,
        firstDate:  firstdate,
        lastDate: date,
      );
      print("picked date is $value");
      print(DateFormatter.dateTimeDT(value));
      setState(() {
        selectedDate = value;
      });
    }
  
    void _submitExpenseData() {
      final enteredAmount =double.tryParse(_amountController.text);
      final amountIsInvalid = enteredAmount==null || enteredAmount<=0;
      if(_titleController.text.trim().isEmpty || amountIsInvalid || selectedDate==null){
        showDialog(
            context: context,
            builder: (ctx){
              return AlertDialog(
                title: const Text("Invalid Input"),
                content: const Text("please enter valid input"),
                actions: [
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: const Text("Okay")
                  )
                ],
              );
            }
        );
        return;
      }
      widget.expense(
          ExpenseModel(
              title: _titleController.text,
              amount: enteredAmount,
              date: selectedDate!,
              category: _selectedCategory
          )
      );
      Navigator.pop(context);
    }
  }
