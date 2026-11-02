// Wird mit esbuild nach dist/app.js gebündelt (npm run build).
const list = document.querySelector("#notes");
const form = document.querySelector("#new");
const who = document.querySelector("#who");
const msg = document.querySelector("#msg");

// Hinter oauth2-proxy: zeigen, wer angemeldet ist (notes-api liest es aus dem Token).
async function whoami() {
  const r = await fetch("/api/whoami");
  if (!r.ok) return;
  const me = await r.json();
  who.textContent = `Angemeldet als ${me.user} (${me.roles.join(", ")})`;
}

async function load() {
  const notes = await (await fetch("/api/notes")).json();
  list.replaceChildren(
    ...notes.map((n) => Object.assign(document.createElement("li"), { textContent: n.text })),
  );
}

form.addEventListener("submit", async (e) => {
  e.preventDefault();
  const text = new FormData(form).get("text");
  const r = await fetch("/api/notes", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ text }),
  });
  msg.textContent = r.ok ? "" : `Nicht gespeichert: ${(await r.json()).error}`;
  form.reset();
  load();
});

whoami();
load();
