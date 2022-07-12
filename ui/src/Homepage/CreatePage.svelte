<script>

  import { createSurvey } from '../UrbitStore'
  import Buttons from '../Homepage/Buttons.svelte'


  let title = ""
  let description = ""
  let slug = ""
  let vis = "private"
  let rlimit = 0

  function create() {
      if (slug === "") {
        return null  
        } else {
          if (title === "") {
              title = "Untitled Form"
          }
          createSurvey({
                  title:title,
                  description:description,
                  visibility:vis,
                  slug:slug,
                  rlimit:rlimit
          })
        }
  }

</script>

<Buttons />
<div class="container">
  <div class="section">
    <div class="title">Title</div>
    <div class="arg">
      <input 
        class="title-input"
        type="text"
        placeholder="Untitled Form"
        bind:value={title} />
    </div>
  </div>
  <div class="section">
    <div class="title">Description</div>
    <div class="arg">
      <textarea 
        bind:value={description}
        placeholder="write an optional description"
      />
    </div>
  </div>
  <div class="section">
    <div class="title">Slug</div>
    <div class="arg slg">
      <span class="slg1">~{window.ship}/</span>
      <input
        class="slg0 {slug === "" ? "alert" : ""}"
        type="text" 
        bind:value={slug} 
        placeholder="cannot-be-empty-dashes-only"
      />
    </div>
  </div>
  <div class="section">
    <div class="title">Visibility</div>
    <div class="arg">
      <button
        class="vis {vis === "public" ? "active" : ""}"
        on:click={()=>vis = "public"}
        >
        Public
      </button>
      <button
        class="vis {vis === "private" ? "active" : ""}"
        on:click={()=>vis = "private"}
        >
        Private
      </button>
    <!--
      <button class="vis">Team</button>
      <button class="vis">Restricted</button>
    -->
    </div>
  </div>
  <div class="section">
    <div class="title">Response Limit</div>
    <div class="arg">
      <input type="number" bind:value={rlimit} min=0/>
      {rlimit === 0 ? "unlimited" : ""}
    </div>
  </div>
  <button
    class="create {slug === "" ? "disabled" : ""}" 
    on:click={create}
  >
    Create New Form
  </button>
</div>

<style>

  .alert {
    background: #f6e9e9;
  }

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

  .active {
    background: black;
    color: white;
    border-color: black;
  }

  .slg {
    display: flex;
    align-items: center;
  }

  .slg0 {
    flex: 1;
  }

  .slg1 {
    width: auto;
    max-width: 50%;
  }

  textarea {
    width: 100%;
    height: 8em;
    padding: 1em;
    box-sizing: border-box;
    border-radius: 4px;
    border: none;
    background-color: #e9e9e9;
    resize: vertical;  
  }

  textarea:focus {
    outline: none;
  }

  .section {
    margin: 2em 0 2em .6em;
    border-bottom: solid 1px #e9e9e9;
    padding-bottom: 2em;
  }

  .title {
    font-size: 1.2em;
    font-weight: 500;
  }

  .arg {
    margin-top: 1em;
    font-size: .8em;
  }

  .create {
    background: white;
    border: solid 1px #e9e9e9;
    color: black;
    margin-bottom: 2em;
    padding: .6em 1em .6em 1em;
  }

  .create:hover {
    background: grey;
    color: white;
  }

  .create:active {
    background: black;
    border-color: black;
    color: white;
  }

  .disabled {
    background: #e9e9e9;
    color: grey;
    cursor: no-drop;
  }

  .disabled:hover {
    background: #e9e9e9;
    color: grey;
  }

  .disabled:active {
    background: #e9e9e9;
    color: grey;
    border-color: #e9e9e9;
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
