<script>

  export let q
  export let ans

</script>

{#each ans.answers as a}
  {#if q.qid === a.id}
    <div class="ans">A: {a.answer}</div>
  {/if}
{/each}
<style>

  .ans {
    border: none;
    width: 90%;
    padding: 1em;
    margin-bottom: .6em;
  
  }

</style>
