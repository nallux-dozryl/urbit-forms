<script>
  import { active } from '../UrbitStore'

    function toCreate() {active.set("create")}
    function toReq() {active.set("req")}

</script>


<div class="top-panel">
  <button
    on:click={toReq}    
  >
    request
  </button>
  <button
    on:click={toCreate}
  >
    new
  </button>
</div>

<style>

  .top-panel {
    display: flex;
  }

  button {
    flex: 1;
    background: white;
    border: 1px solid black;
    margin: 1em;
    padding: .6em;
  }

  button:hover {
    background: black;
    color: white;
    border: 1px solid black;
  }

</style>
