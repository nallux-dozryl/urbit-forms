<script>
  import { active, editSlug } from '../../UrbitStore'

</script>

  <div class="section">
    <div class="title">Slug</div>
    <div class="arg slg">
      <span class="slg1">~{$active[0].author}/</span>
      <input 
        class="slg0"
        type="text"
        on:blur={editSlug({id: $active[0].id, slug: $active[0].slug})}
        bind:value={$active[0].slug}
      />
    </div>
  </div>

<style>

  .slg {
    display: flex;
    align-items: center;
  }

  .slg0 {
    flex: 1;
  }

  .slg1 {
    width: auto;
    max-width: 50%;
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

  input {
    border: none;
    background: #e9e9e9;
    padding: 1em;
    border-radius: 4px;
    margin-left: .4em;
    color: #505050;
  }

  input:focus {
    outline: none;
  }

</style>
