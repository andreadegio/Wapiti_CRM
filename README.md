### Elenco delle opzioni per la toolbar di Vue2Editor
var fullToolbar = [
[{ 'font': [] }],
[{ 'header': [false, 1, 2, 3, 4, 5, 6, ] }],
[{ 'size': ['small', false, 'large', 'huge'] }],
['bold', 'italic', 'underline', 'strike'],
[{'align': ''}, {'align': 'center'}, {'align': 'right'}, {'align': 'justify'}],
[{ 'header': 1 }, { 'header': 2 }],
['blockquote', 'code-block'],
[{ 'list': 'ordered'}, { 'list': 'bullet' }, { 'list': 'check' }],
[{ 'script': 'sub'}, { 'script': 'super' }],
[{ 'indent': '-1'}, { 'indent': '+1' }],
[{ 'color': [] }, { 'background': [] }],
['link', 'image', 'video', 'formula'],
[{ 'direction': 'rtl' }],
['clean'],
]

## Modifiche per rilascio in produzione/staging
nel main.js modificare il baseURL per axiosFileUploader

## Errore chunkLoading
modifcare le regole di routing nel file index.js raggruppando i componenti con un nome per il chunk di webpack

## Modifiche vue-file-agent
Per una gestione personalizzata del caricamento dei file (materiale, comunicazioni, formazione) ho modificato il file del modulo vue-file-agent (\vue-file-agent\dist\vue-file-agent.umd.js) gestendo l'invio dei parametri passati con un json

