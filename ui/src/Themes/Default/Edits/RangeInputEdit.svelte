<script>

  import { active, addQuestion } from '../../../UrbitStore'

  export let i
  export let n

  function handleSwitch(type) {
      const  q = $active[1][n].sec[i]
      q["x"] = [type]
      active.set($active)
      q["id"] = $active[0].id
      q["sid"] = n + 1
      addQuestion(q)
  }

  function handleUpdate() {
      const  q = $active[1][n].sec[i]
      q["id"] = $active[0].id
      q["sid"] = n + 1
      addQuestion(q)
  }
</script>

  <div class="selector">
    <button
      class="switch"
      class:active="{$active[1][n].sec[i].x[0] === "linear"}"
      on:click={()=>handleSwitch("linear")}
    >
      Linear
    </button>
    <button 
      class="switch"
      class:active="{$active[1][n].sec[i].x[0] === "continuous"}"
      on:click={()=>handleSwitch("continuous")}
    >
      Continuous
    </button>
  </div>
  <div class="min-max">
    <div class="m">
      <div class="words">Min</div>
      <input
        type="number"
        bind:value={$active[1][n].sec[i].min} 
        on:blur={handleUpdate}
      />
    </div>
    <div class="m">
      <div class="words">Max</div>
      <input
        type="number"
        bind:value={$active[1][n].sec[i].max}
        on:blur={handleUpdate}
      />
    </div>
  </div>
<style>

  .min-max {
    display: flex;
    gap: 2em;
    padding: 1em 2em 0 2em;
  }

  .words {
    font-size: .7em;
    color: #666;
    padding: .3em 0 .3em .3em;
  }


  .m {
    flex: 1;
    display: flex;
    flex-direction: column;
  }

  .m input {
    padding: 1em;
    border: none;
    background: #e9e9e9;
    border-radius: 4px;
  }

  .selector {
    display: flex;
    background: #e9e9e9;
    padding: 3px;
    border-radius: 8px;
    gap: 3px;
  }

  .switch {
    flex: 1;
    border: none;
    font-size: .8em;
    padding: .8em;
    border-radius: 6px;
    background: none;
  }

  .active {
    background: white;
  }

</style>
