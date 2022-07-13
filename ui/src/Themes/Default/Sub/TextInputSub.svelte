<script>

  import NotAnswered from './NotAnswered.svelte'

  export let info, q

</script>

{#if (info.a[0] === undefined) || (info.a[0] === '')}
  <NotAnswered />
{:else if q.x[0] === "short"}
  <input
    type="text"
    value={info.a[0]}
    disabled
  />
{:else if q.x[0] === "essay"}
  <textarea 
    type="text"
    placeholder="Type your answer here"
    bind:value={info.a[0]}
    disabled
  />
{/if} 
<style>

  .unanswered {
    margin-top: 1em;
    font-size: .8em;
    font-weight: 600;
    color: #666;
  }

  input {
    border: none;
    background: #e9e9e9;
    padding: 1em;
    border-radius: 4px;
    margin-left: .4em;
    color: #505050;
    width: 100%;
    box-sizing: border-box;

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
    height: 16em;
    resize: none;
  }

  textarea:focus {
    outline: none;
  }

</style>
