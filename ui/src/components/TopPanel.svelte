<script>
  import { active } from '../UrbitStore'

  function toNull() {active.set(null)}

</script>


<div class="top-panel">
  <button>
    request
  </button>
  <button
    on:click={toNull}
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
