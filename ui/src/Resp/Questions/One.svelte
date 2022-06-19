<script>
  import { editDraft } from '../../UrbitStore'

  export let q;
  export let ans;

</script>

<div class="container">
  {#each ans.answers as a}
    {#if q.qid === a.id}
      {#if q.x}
        {#each q.x as ox, i}
          <div class="option">
            {#if ox === a.answer}
              <input type="radio" checked disabled />
            {:else}
              <input type="radio" disabled />
            {/if}
            <label>{ox}</label>
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
