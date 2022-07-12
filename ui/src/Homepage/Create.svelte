<script>
  let templates = ['Coming Soon','Coming Soon','Coming Soon']
  import { isCreate } from '../UrbitStore'
</script>

<div class="title">
  Start a new form
</div>
<div class="subtitle">
  Create forms from scratch or start with a template.
</div>
<div class="templates">
  <button class="card" on:click={()=>isCreate.set("scratch")}>
    <div class="sel">
      From Scratch
    </div>
  </button>
  {#each templates as template}
    <button class="card template">
      <div class="sel">{template}</div>
    </button>
  {/each}
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

  .templates {
    display: flex;
    flex-wrap: wrap;
    gap: .6em;
  }

  .sel {
    margin: 2.4em;
    font-size: .8em;
    font-weight: 500;
  }

  .card {
    flex: 1 0 21%;
    text-align: center;
    height: 5em;
    border: solid 1px #e9e9e9;
    border-radius: 6px;
    background: white;
    text-decoration: none;
    font-weight: 500;
    color: black;
  }

  .template {
    background: #f1f1f1;
  }

  .card:hover {
    color: white;
    background: grey;
  }

  .card:active {
    color: white;
    background: black;
  }

</style>
