const express = require("express");
const cors = require("cors");
const app = express();
app.use(cors());
app.use(express.json());

/* authentication service */
//login

app.post("/auth/login", (req, res) => {
    const { email, password } = req.body;
    const user = users.find(user => user.email === email);
    if (!user) {
        return res.status(404).send({ message: "User with this email not found" });
    }

    if (user.password !== password) {
        return res.status(500).send({ message: "Invalid creadentials" });
    }
    return res.status(200).send({ data: user, message: "authenticated successfully" });
})

//signup
app.post("/auth/register", (req, res) => {
    const { name, email, password } = req.body;
    const user = users.find(user => user.email === email);
    if (user) {
        return res.status(400).send({ message: "This email is already in use" });
    }
    users.push({ id: users.length++, name, email, password })

    return res.status(200).send({ message: "signup successfully" });
})


let tasks = [
    { id: 1, title: "note 1 title", content: "this is a sample content", isDone: false, userId: 1 },
    { id: 2, title: "note 2 title", content: "this is a sample content", isDone: false, userId: 1 },
    { id: 3, title: "note 3 title", content: "this is a sample content", isDone: false, userId: 2 },
    { id: 4, title: "note 4 title", content: "this is a sample content for user 2", isDone: false, userId: 2 },
    { id: 5, title: "note 5 title", content: "this is a sample content for user 2", isDone: false, userId: 1 },
    { id: 66, title: "note 66 title", content: "this is a sample content", isDone: false, userId: 1 },
];

const users = [
    { id: 1, name: "admin", email: "admin@mail.com", password: "admin" },
    { id: 2, name: "user", email: "user@mail.com", password: "user" },
]



app.get("/tasks/user/:id", (req, res) => {
    const user_id = req.params.id;
    console.log("requesting tasks for user with ID = " + user_id);
    const user_tasks = tasks.filter(t => t.userId == user_id);
    console.log("========== tasks by user ==========")
    console.log(user_tasks);
    /* if (!user) {
        return res.status(500).send({ message: "user with this id not found" });
    } */
    return res.status(200).send({ message: "tasks retrieved successfully", data: user_tasks });
})


app.get("/tasks/:id/done", (req, res) => {
    const id = req.params.id;
    console.log("mark task with ID " + id + " as done");
    const task_id = req.params.id;
    const task = tasks.find(t => t.id == task_id);
    task.isDone = !task.isDone;
    return res.status(200).send({ message: "tasks updated successfully" });
})

app.get("/notes/:id", (req, res) => {
    setTimeout(() => {
        const id = +req.params.id;
        const note = notes.find(note => note.id === id);
        return res.status(200).send(note);
    }, 2000);
})

app.delete("/notes/:id", (req, res) => {
    const id = +req.params.id;
    notes = notes.filter(note => note.id !== id);
    return res.status(200).send({ message: "note deleted" });
})

app.post("/tasks", (req, res) => {
    console.log(req.body);
    const new_task = { ...req.body, id: tasks.length + 1 };
    tasks.push(new_task);
    console.log(tasks);

    return res.status(201).send({ message: "Task created successfully" });
})

app.put("/notes", (req, res) => {
    const updated = req.body;
    const index = notes.findIndex(note => note.id === updated.id);
    notes[index] = res.body;
    return res.status(201).send({ message: "note updated" });
})
const PORT = 3000;

app.listen(PORT, () => console.log("Server listenting on port " + PORT));