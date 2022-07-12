<script>

  import { active, editDraft } from '/src/UrbitStore'

  export let n, i

  function handleClick() {
      const data = {
        id: $active[0].id,
        sid: n + 1,
        qid: $active[1][n].sec[i].qid,
        head: "answer",
        accept: "text",
        a: $active[2][n].sec[i].a,
        b:[],
        c:[]
      }
      editDraft(data)  
  }

</script>

{#if $active[1][n].sec[i].x[0] === "short"}
  <input
    type="text"
    placeholder="Type your answer here"
    bind:value={$active[2][n].sec[i].a[0]}
    on:blur={handleClick}
  />
{:else if $active[1][n].sec[i].x[0] === "essay"}
  <textarea 
    type="text"
    placeholder="Type your answer here"
    bind:value={$active[2][n].sec[i].a[0]}
    on:blur={handleClick}
  />
{/if} 
<style>

  input {
    border: none;
    background: #e9e9e9;
    padding: 1em;
    border-radius: 4px;
    margin-left: .4em;
    color: #505050;
    width: 100%;
    box-sizing: border-box;
    margin-bottom: 2em;

  }

  input:focus {
    outline: none;
  }

  textarea {
    border: none;
    background: #e9e9e9;
    padding: 1em;
    border-radius: 4px;
    margin-left: .4em;
    color: #505050;
    width: 100%;
    box-sizing: border-box;
    margin-bottom: 2em;
    height: 16em;
    resize: none;
  }

  textarea:focus {
    outline: none;
  }

</style>
