<script>
  import { active } from '../UrbitStore'
  import DeleteForm from './DeleteForm.svelte'
  import Title from './Details/Title.svelte'
  import Description from './Details/Description.svelte'
  import Slug from './Details/Slug.svelte'
  import Visibility from './Details/Visibility.svelte'
  import ResLimit from './Details/ResLimit.svelte'

</script>

<div>
  {#if $active[0].author === window.ship}
  <Title />
  <Description />
  <Slug />
  <Visibility />
  <!--
  <ResLimit />
  -->
  {/if}
  <DeleteForm />
</div>
