<div class="container">
  <div class="section">
    <div class="title">File Name</div>
    <div class="arg">
      <input class="title-input" type="text" value="palnet-slug-datetime" />
    </div>
  </div>
  <div class="section">
    <div class="title">Export As</div>
    <div class="arg">
      <button class="vis">CSV</button>
    </div>
  </div>
  <div class="section">
    <div class="title">Save to</div>
    <div class="arg">
      <button class="big">Silo</button>
      <button class="big">Download to Local PC</button>
      <button class="big">Send to email address</button>
    </div>
  </div>
  <div class="section">
    <div class="title">Export</div>
    <button class="archive">Export this form!</button>
  </div>
</div>

<style>

  .vis {
    width: 7em;
    background: white;
    border: solid 1px #e9e9e9;
  }

  .vis:hover {
    border-color: grey;
    background: grey;
    color: white;
  }

  .big {
    width: 80%;
    background: white;
    border: solid 1px #e9e9e9;
    margin: 1em 10% 0 10%;
  }

  .big:hover {
    border-color: grey;
    background: grey;
    color: white;
  }

  .section {
    margin: 2em 0 2em .6em;
  }

  .title {
    font-size: 1.2em;
    font-weight: 500;
  }

  .arg {
    margin-top: 1em;
    font-size: .8em;
  }

  .archive {
    background: white;
    border: solid 1px #e9e9e9;
  }

  .archive:hover {
    background: grey;
    border-color: grey;
    color: white;
  }

  .archive:active {
    background: black;
    border-color: black;
    color: white;
  }

  input {
    border: none;
    background: #e9e9e9;
    padding: 1em;
    border-radius: 4px;
    margin-left: .4em;
    color: #505050;
  }

  .title-input {
    width: 100%;
    box-sizing: border-box;

  }

  input:focus {
    outline: none;
  }

  button {
    padding: .6em;
    border-radius: 4px;
    margin: 1em 1em 0 0;
  }

</style>
