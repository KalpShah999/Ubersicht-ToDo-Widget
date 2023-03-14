
# User Customization 
title = "Todo"
title_font_size = 20
task_font_size = 10
screen_width = 200
bulletPoint = "∆" # This is the symbol used as a trailing point for all tasks 
refreshFrequency: 10 # The smaller the number, the faster it'll refresh 

# ------------------------------------------------------------------

# DO NOT TOUCH (unless you know what you're doing)

root = exports ? this
root.tasks = []
root.taskList = []
root.readingFile = true

max_tasks = 25
todolistfile = "./.todo.txt" # File names that start with '.' are hidden files 

standardizeTasks: () ->
  if (root.readingFile)
    promise = @run "cat #{todolistfile}"

    # Read the external file and add the elements to the list 
    promise.then (result) ->
      taskList = result.split("\n")
      root.tasks = taskList
      root.tasks.pop()
      root.taskList = []
      root.taskList.push ("#{bulletPoint} " + i) for i in root.tasks

    root.readingFile = false
    return root.taskList
  else 
    root.taskList = []
    root.taskList.push ("#{bulletPoint} " + i) for i in root.tasks
    return root.taskList
  
updateText: (number, tasks, newContent) ->
  console.log(number)
  if (tasks[number] != undefined)
    $(newContent).find('.task' + (number + 1)).text(tasks[number])
  else 
    $(newContent).find('.task' + (number + 1)).text("")

afterRender: (newContent) ->
  # # Open the text file containing the tasks (click on the title) 
  # $(newContent).find(".txt-title").on 'click', =>
  #   @run "open #{todolistfile}"

  # Delete a task 
  $(newContent).find(".txt-task").on 'click', (event) => 
    taskText = event.target.textContent
    taskText = taskText.slice(bulletPoint.length + 1)
    root.tasks = root.tasks.filter (word) -> word isnt taskText

    # Save the file 
    content = ""
    content = content + i + "\n" for i in root.tasks
    console.log(content)
    @run "echo -n \"#{content}\" \> #{todolistfile}"

  # Add a new task 
  $(newContent).find(".addBtn").on 'click', => 

    # Get the value of the task that was typed in 
    newTaskText = document.getElementById("myInput").value
    document.getElementById("myInput").value = ""

    # Add the task to the task list if there are at most 9 tasks currently 
    if newTaskText != "" && root.tasks.length < max_tasks
      root.tasks.push(newTaskText)

      # Save the file 
      content = ""
      content = content + i + "\n" for i in root.tasks
      console.log(content)
      @run "echo -n \"#{content}\" \> #{todolistfile}"

update: (output, newContent) ->
  tasks = @standardizeTasks()

  $(newContent).find('.txt-title').text("- " + title + " -") 

  @updateText(i, tasks, newContent) for i in [0..(max_tasks - 1)]

refreshFrequency: 10

style: """

  @font-face {
    font-family: Anurati;
    src: url("Anurati.otf") format("opentype");
  }

  color: #000
  font-color: #ca9991
  top: 2%
  left: 1%
  font-family: Helvetica, sans-serif
  font-size: 10px
  line-height: 1
  opacity: 0.8
  //text-transform: uppercase
  //transform: translate(-50%, -50%)

  .container
    text-align: left
    display: block
    width: #{screen_width}px
    height: 100%
    overflow: hidden
    background-color: rgba(0, 0, 0, 0.2)
    padding: 15px
    border-radius: 25px;

  .txt-task
    line-height: 2
    font-size: #{task_font_size}px
    color: #FFFFFF
    user-select: none;
    cursor: pointer;
    transition: 0.3s;

  .txt-task:hover {
    background-color: rgba(0, 0, 0, 0.3);
  }

  .txt-title
    text-align: center
    line-height: 1
    font-size: #{title_font_size}px
    color: #FFFFFF
    user-select: none;
    cursor: default;
    
  input {
    margin-top: 5px;
    padding: 3px;
    padding-left: 6px;
    border: none;
    border-radius: 10px;
    font-size: 10px;
    width: 61%;
    float: left;
    background-color: rgba(0, 0, 0, 0.3);
    color: rgba(255, 255, 255, 0.5);
  }

  .addBtn {
    margin-top: 5px;
    margin-left: 5%;
    padding: 4px;
    border: none;
    border-radius: 10px;
    width: 25%;
    font-size: 10px;
    color: rgba(255, 255, 255, 0.5);
    float: left;
    text-align: center;
    cursor: pointer;
    transition: 0.3s;
    background-color: rgba(0, 0, 0, 0.3);
    user-select: none;
  }

  .addBtn:hover {
    background-color: rgba(0, 0, 0, 0.7);
  }
"""


render: () -> """
  <div class='container'>
    <div class='txt-title'>
      <span class="title">Text</span>
    </div>
    <hr style="border: 0; height: 2px; background-color: #FFFFFF; user-select: none;">
    <div class='txt-task task1'></div>
    <div class='txt-task task2'></div>
    <div class='txt-task task3'></div>
    <div class='txt-task task4'></div>
    <div class='txt-task task5'></div>
    <div class='txt-task task6'></div>
    <div class='txt-task task7'></div>
    <div class='txt-task task8'></div>
    <div class='txt-task task9'></div>
    <div class='txt-task task10'></div>
    <div class='txt-task task11'></div>
    <div class='txt-task task12'></div>
    <div class='txt-task task13'></div>
    <div class='txt-task task14'></div>
    <div class='txt-task task15'></div>
    <div class='txt-task task16'></div>
    <div class='txt-task task17'></div>
    <div class='txt-task task18'></div>
    <div class='txt-task task19'></div>
    <div class='txt-task task20'></div>
    <div class='txt-task task21'></div>
    <div class='txt-task task22'></div>
    <div class='txt-task task23'></div>
    <div class='txt-task task24'></div>
    <div class='txt-task task25'></div>
     <div class='add-container'> 
        <input type="text" id="myInput" placeholder="New Task..."><span class="addBtn" id="addBtnID">Add</span>
     </div>
  </div>
"""
