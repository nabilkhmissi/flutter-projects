const express = require("express");
const cors = require("cors");
const app = express();
app.use(cors());
app.use(express.json());

/* authentication service */
//login

app.post("/auth/login", (req, res) => {
    const { email, password } = req.body;
    console.log(email + password);
    const user = users.find(user => user.email === email);
    if (!user) {
        return res.status(404).send({ message: "User with this email not found" });
    }

    if (user.password !== password) {
        return res.status(500).send({ message: "Invalid creadentials" });
    }
    console.log(user);

    return res.status(200).send({ data: user, message: "authenticated successfully" });
})

//signup
app.post("/auth/register", (req, res) => {
    const { name, email, password } = req.body;
    console.log(name + email + password);
    const user = users.find(user => user.email === email);
    if (user) {
        return res.status(400).send({ message: "This email is already in use" });
    }
    users.push({ id: users.length++, name, email, password })

    return res.status(200).send({ message: "signup successfully" });
})


let notes = [
    { id: 1, title: "note 1 title", content: "this is a sample content" },
    { id: 2, title: "note 2 title", content: "this is a sample content" },
    { id: 3, title: "note 3 title", content: "this is a sample content" },
    { id: 4, title: "note 4 title", content: "this is a sample content" },
    { id: 5, title: "note 5 title", content: "this is a sample content" },
    { id: 66, title: "note 66 title", content: "this is a sample content" },
];

const users = [
    { id: 1, name: "admin", email: "admin@mail.com", password: "admin" },
    { id: 2, name: "user", email: "user@mail.com", password: "user" },
]



app.get("/notes/user/:id", (req, res) => {
    const user_id = req.params.id;
    const user = users.find(u => u.id === user_id);
    if (!user) {
        return res.status(500).send({ message: "user with this id not found" });
    }
    return res.status(200).send({ message: "notes retrieved", data: user.notes });
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

app.post("/notes", (req, res) => {
    console.log(req.body);
    const new_note = { ...req.body, id: notes.length + 1 };
    console.log(new_note);

    notes.push(new_note);
    return res.status(201).send({ message: "note created" });
})

app.put("/notes", (req, res) => {
    console.log("update");
    const updated = req.body;
    const index = notes.findIndex(note => note.id === updated.id);
    notes[index] = res.body;
    return res.status(201).send({ message: "note updated" });
})
const PORT = 3000;

app.listen(PORT, () => console.log("Server listenting on port " + PORT));