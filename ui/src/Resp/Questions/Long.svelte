<script>

  export let q
  export let ans


</script>

{#each ans.answers as a}
  {#if q.qid === a.id}
    {#each a.answer.split(/\r?\n/) as para}
      {#if para}
        <div class="ans">{para}</div>
      {:else}
        <br/>
      {/if}
    {/each}
  {/if}
{/each}

<style>

  .ans {
    border: none;
    width: 90%;
    color: black;
    padding: 0 1em 0 1em;
    font-size: .8em;
  }

</style>
