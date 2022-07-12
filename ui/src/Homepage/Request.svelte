<script>

  import { requesting, requestForm } from '../UrbitStore'

  let addr = "";
  let isBlock = true;
  let arr = [];

  function handleKeyUp() {
      arr = addr.split("/")
      ship = arr[0]
      if ((arr[0] = ship) && (arr[1])) {
        isBlock = false
      } else {
        isBlock = true
      }
  }

</script>

  <svelte:window on:keyup={handleKeyUp}/>
<div class="title">
  Fill out a form
</div>
<div class="subtitle">
  Paste your invite code below to access the form you want to fill out.
</div>
<div class="request-form">
  <input 
    type="text" 
    placeholder="~sampel-palnet/important-form" 
    bind:value={addr} 
    disabled={$requesting}
  />
  <button 
    class="ask"
    on:click={()=>{handleKeyUp(); requestForm(window.ship, addr)}}
    disabled={isBlock || $requesting}
  >
  {$requesting ? "Requesting" : "Request form"}
  </button>
</div>

<style>

  .title {
    font-size: 1.1em;
    font-weight: 500;
  }

  .subtitle {
    color: #666;
    font-size: 0.7em;
    padding: .2em 0 1em 0;
  }

  .request-form {
    display: flex;
  }

  input {
    flex: 1;
    background: #e9e9e9;
    padding: .6em 0 .6em .6em;
    border: none;
    border-radius: 4px;
    margin-right: 1em;
  }

  input:focus {
    outline: none;
  }

  .ask {
    background: white;
    border: solid 1px #e9e9e9;
    border-radius: 4px;
    padding: 0 .6em 0 .6em;
  }

  .ask:hover {
    background: grey;
    border: solid 1px grey;

    color: white;
  }

  .ask:active {
    background: black;
    border: solid 1px black;
    color: white;
  }

  .ask:disabled {
    background: #e9e9e9;
    border-color: #e9e9e9;
    color: grey;
    cursor: no-drop;
  }

</style>
