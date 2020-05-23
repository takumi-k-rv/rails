class Todo {
  constructor(textField, sendButton, todoList, deleteButtons) {
    this.textField = textField
    this.sendButton = sendButton
    this.todoList = todoList
    this.host     = "http://localhost:3001"
    this.deleteButtons = deleteButtons
    this.fetchTodos();
    this.setEventListener();
  }

  setEventListener() { //send click
    var _this = this
    this.sendButton.addEventListener("click", function(e) {
      var text = _this.textField.value
      _this.postTodo(text);
    });
  }

  clickDeleteButton() { //delete
    var _this = this
    for (let i = 0; i < this.deleteButtons.length; i++) {
      var btn = this.deleteButtons[i]
      btn.addEventListener("click", function(e) {
        axios.delete(_this.host + '/todos/' + e.target.dataset.id).then(function() {
          e.target.parentNode.remove(e.target);
        })
      })
    }
  }

  postTodo(text) { // post /todos
    var _this = this
      axios.post(this.host + '/todos', { title: text, created_by: 1 })
      .then(function(res) {
        var todo = res.data
        _this.appendTodo(todo);
        _this.removeTextFromInput();
        _this.clickDeleteButton();
      });
  }

  removeTextFromInput() {
    this.textField.value = '';
  }

  fetchTodos() {
    var _this = this
    axios.get(this.host + '/todos')
      .then(function(res) {
        var todos = res.data
        todos.forEach(function(todo) {
          _this.appendTodo(todo)
        });
        _this.clickDeleteButton();
      });
  }

  appendTodo(todo) {
    var list = document.createElement("li")
    list.innerText = todo.title
    list.classList.add('item')
    const button = `<div>${todo.title}</div>
                      <button class="delete" data-id=${todo.id}></button>`
    list.innerHTML = button
    this.todoList.appendChild(list)
  }
}


window.onload = function() { //初期状態
  todo = new Todo(
    document.getElementById("field"),
    document.getElementById("btn"),
    document.getElementById("todo"),
    document.getElementsByClassName("delete")
  )
}
