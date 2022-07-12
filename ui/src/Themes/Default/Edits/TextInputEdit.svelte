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

</script>

  <div class="selector">
    <button
      class="switch"
      class:active="{$active[1][n].sec[i].x[0] === "short"}"
      on:click={()=>handleSwitch("short")}
    >
      One Line
    </button>
    <button 
      class="switch"
      class:active="{$active[1][n].sec[i].x[0] === "essay"}"
      on:click={()=>handleSwitch("essay")}
    >
      Paragraph
    </button>
  </div>

<style>

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
