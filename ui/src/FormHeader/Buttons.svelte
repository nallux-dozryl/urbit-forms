<script>

  import { isAdmin } from '../UrbitStore'

  export let show


  function toggleEdit() {
    $isAdmin = !$isAdmin
  }

</script>
<div class="container">
  <a class="btn" href="/apps/forms">🢐 Menu</a>
  {#if show}
    {#if $isAdmin}
      <button on:click={toggleEdit} class="btn func">Preview</button>
    {:else}
      <button on:click={toggleEdit} class="btn func">Edit</button>
    {/if}
  {/if}
</div>

<style>

  .container {
    margin-top: 2em;
  }

  .btn {
    padding: .4em 1em .4em 1em;
    border: solid 1px #e9e9e9;
    border-radius: 4px;
    text-decoration: none;
    color: black;
    font-size: .8em;
    background: white;
  }

  .btn:hover {
    border: solid 1px grey;
    color: white;
    background: grey;    
  }

  .btn:active {
    border: solid 1px black;
    color: white;
    background: black;
  }

  .func {
    float: right;
    margin-left: 1em;
    width: 6em;
  }

</style>
