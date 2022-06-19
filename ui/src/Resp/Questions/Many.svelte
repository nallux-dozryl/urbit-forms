<script>

  export let q;
  export let ans;

</script>
<div class="container">
  {#each ans.answers as a}
    {#if q.qid === a.id}
      {#if q.x}
        {#each q.x as ox, i}
          <div class="option">
            {#if a.answer.includes(ox)}
              <input type="checkbox" checked disabled />
              <span>{ox}</span>
            {:else}
              <input type="checkbox" disabled />
              <span>{ox}</span>
            {/if}
          </div>
        {/each}
      {/if}
    {/if}
  {/each}
</div>



<style>

  .container {
    display: flex;
    flex-direction: column;
  }

  .option {
    flex: 1;
  }

</style>
