document.addEventListener("DOMContentLoaded", function() {
    // Change "Exercise" to "Задача" in problem titles
    document.querySelectorAll(".problem .admonition-title").forEach(el => {
        el.innerHTML = el.innerHTML.replace("Exercise", "Задача");
    });

    // Change "Example" to "Пример" in example titles
    document.querySelectorAll(".example .admonition-title").forEach(el => {
        el.innerHTML = el.innerHTML.replace("Example", "Пример");
    });

    // Change "Example X" to "Пример X" in cross-references
    document.querySelectorAll("a.reference.internal").forEach(el => {
        if (el.innerHTML.startsWith("Example ")) {
            el.innerHTML = el.innerHTML.replace("Example", "Пример");
        }
    });

    // Change "Exercise X" to "Задача X" inside cross-references with <span>
    document.querySelectorAll("a.reference.internal span.std-numref").forEach(el => {
        if (el.innerHTML.startsWith("Exercise ")) {
            el.innerHTML = el.innerHTML.replace("Exercise", "Задача");
        }
    });

    // Change "Note" to "Забележка" in note admonitions
    document.querySelectorAll(".note .admonition-title").forEach(el => {
        el.innerHTML = el.innerHTML.replace("Note", "Забележка");
    });
});
