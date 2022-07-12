<script>

  import { isCreate } from '../UrbitStore'

</script>
<div class="container">
  <button class="btn" on:click={()=>isCreate.set(null)}>🢐 Menu</button>
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

</style>
