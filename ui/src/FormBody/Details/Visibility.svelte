<script>
  import { active, editVis } from '../../UrbitStore'

</script>

<div class="section">
  <div class="title">Visibility</div>
  <div class="arg">
    <button 
      class:active={$active[0].visibility === "public"}
        on:click={()=>{
          $active[0].visibility = "public"
          editVis({id: $active[0].id, vis: $active[0].visibility})
         }}
    >
      Public
    </button>
    <button 
      class:active={$active[0].visibility === "private"}
        on:click={()=>{
          $active[0].visibility = "private"
          editVis({id: $active[0].id, vis: $active[0].visibility})
       }}
    >
      Private
    </button>
    <!--
    <button class="vis">Team</button>
    <button class="vis">Restricted</button>
    -->
  </div>
</div>

<style>

  .active {
    background: black;
    border-color: black;
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

  button {
    width: 7em;
    background: white;
    border: solid 1px #e9e9e9;
    padding: .6em;
    border-radius: 4px;
    margin: 1em 1em 0 0;
  }

  button:hover {
    border-color: grey;
    background: grey;
    color: white;
  }

</style>
